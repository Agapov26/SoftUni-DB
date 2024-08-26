namespace MusicHub
{
    using System;
    using System.Text;
    using Data;
    using Initializer;

    public class StartUp
    {
        public static void Main()
        {
            MusicHubDbContext context =
                new MusicHubDbContext();

            DbInitializer.ResetDatabase(context);

            //Test your solutions here
        }

        public static string ExportAlbumsInfo(MusicHubDbContext context, int producerId)
        {
            var albums = context.Albums
                .Where(a => a.ProducerId == producerId)
                .Select(a => new
                {
                    a.Name,
                    a.ReleaseDate,
                    a.Producer,
                    Songs = a.Songs.Select(s => new
                    {
                        s.Name,
                        s.Price,
                        s.Writer
                    })
                    .OrderByDescending(s => s.Name)
                    .ThenBy(s => s.Writer.Name)
                    .ToList(),
                    a.Price
                })
                .ToList()
                .OrderByDescending(a => a.Price);

            StringBuilder sb = new StringBuilder();

            if (albums.Any())
            {
                foreach (var album in albums)
                {
                    sb.AppendLine($"-AlbumName: {album.Name}");
                    sb.AppendLine($"-ReleaseDate: {album.ReleaseDate.ToString("MM/dd/yyyy")}");

                    if (album.Producer != null)
                    {
                        sb.AppendLine($"-ProducerName: {album.Producer.Name}");
                    }

                    if (album.Songs.Any())
                    {
                        sb.AppendLine($"-Songs:");

                        int songCounter = 0;
                        foreach (var song in album.Songs)
                        {
                            songCounter++;

                            sb.AppendLine($"---#{songCounter}");
                            sb.AppendLine($"---SongName: {song.Name}");
                            sb.AppendLine($"---Price: {song.Price:f2}");
                            sb.AppendLine($"---Writer: {song.Writer.Name}");
                        }
                    }

                    sb.AppendLine($"-AlbumPrice: {album.Price:f2}");
                }
            }
            else
            {
                throw new InvalidOperationException($"No albums found with producer id: {producerId}!");
            }

            return sb.ToString().TrimEnd();
        }

        public static string ExportSongsAboveDuration(MusicHubDbContext context, int duration)
        {
            var songs = context.Songs
                .Where(s => s.Duration > new TimeSpan(0, 0, duration))
                .Select(s => new
                {
                    s.Name,
                    PerformerNames = s.SongPerformers
                        .OrderBy(sp => sp.Performer.FirstName)
                        .ThenBy(sp => sp.Performer.LastName)
                        .Select(sp => $"{sp.Performer.FirstName} {sp.Performer.LastName}")
                        .ToList(),
                    WriterName = s.Writer.Name,
                    AlbumProducer = s.Album.Producer,
                    Duration = s.Duration.ToString("c")
                })
                .OrderBy(s => s.Name)
                .ThenBy(s => s.WriterName)
                .ToList();

            StringBuilder sb = new StringBuilder();

            if (songs.Any())
            {
                int songCounter = 0;
                foreach (var song in songs)
                {
                    songCounter++;
                    sb.AppendLine($"-Song #{songCounter}");
                    sb.AppendLine($"---SongName: {song.Name}");
                    sb.AppendLine($"---Writer: {song.WriterName}");

                    if (song.PerformerNames.Any())
                    {
                        foreach (var performerName in song.PerformerNames)
                        {
                            sb.AppendLine($"---Performer: {performerName}");
                        }
                    }

                    if (song.AlbumProducer != null)
                    {
                        sb.AppendLine($"---AlbumProducer: {song.AlbumProducer.Name}");
                    }

                    sb.AppendLine($"---Duration: {song.Duration}");
                }
            }
            else
            {
                throw new InvalidOperationException($"No songs found with duration above {duration}!");
            }

            return sb.ToString().TrimEnd();
        }
    }
}
