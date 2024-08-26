using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MusicHub.Data.Models
{
    public class Album
    {
        public Album()
        {
            Songs = new HashSet<Song>();
        }

        [Key]
        public int Id { get; set; }

        [Required]
        [MaxLength(40)]
        public string Name { get; set; } = null!;

        [Required]
        public DateTime ReleaseDate { get; set; }

        public decimal Price => Songs.Sum(s => s.Price);

        public int? ProducerId { get; set; }

        [ForeignKey(nameof(ProducerId))]
        public virtual Producer? Producer { get; set; }

        public virtual ICollection<Song> Songs { get; set; }
    }
}
