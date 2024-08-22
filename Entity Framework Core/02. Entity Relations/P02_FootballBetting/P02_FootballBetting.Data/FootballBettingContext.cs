using Microsoft.EntityFrameworkCore;
using P02_FootballBettingSystem.Models;
using System;
using System.Collections.Generic;
using System.Diagnostics.Metrics;
using System.Drawing;
using System.Linq;
using System.Numerics;
using System.Text;
using System.Threading.Tasks;

namespace P02_FootballBetting.Data
{
    public class FootballBettingContext : DbContext
    {
        private const string connectionString = "Server=.;Database=FootballBookmakerSystem;Integrated Security=True;";

        public FootballBettingContext()
        {

        }

        /// <summary>
        /// Constructs context with options
        /// </summary>
        /// <param name="options">Options</param>
        public FootballBettingContext(DbContextOptions options) : base(options)
        { 

        }

        public DbSet<User> Users { get; set; }
        public DbSet<Player> Players { get; set; }
        public DbSet<Team> Teams { get; set; }
        public DbSet<Position> Positions { get; set; }
        public DbSet<PlayerStatistic> PlayersStatistics { get; set; }
        public DbSet<Game> Games { get; set; }
        public DbSet<Bet> Bets { get; set; }
        public DbSet<Color> Colors { get; set; }
        public DbSet<Town> Towns { get; set; }
        public DbSet<Country> Countries { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                optionsBuilder.UseSqlServer(connectionString);
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<PlayerStatistic>()
                .HasKey(pk => new { pk.GameId, pk.PlayerId });

            base.OnModelCreating(modelBuilder);
        }
    }
}
