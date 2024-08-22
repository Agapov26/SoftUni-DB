using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace P02_FootballBettingSystem.Models
{
    public class User
    {
        public User()
        {
            Bets = new HashSet<Bet>();
        }

        [Key]
        public int UserId { get; set; }

        [Required]
        [MaxLength(ValidationConstants.UsernameMaxLength)]
        public string Username { get; set; } = null!;

        [Required]
        [MaxLength(ValidationConstants.NameMaxLength)]
        public string Name { get; set; } = null!;

        [Required]
        [MaxLength(ValidationConstants.PasswordMaxLength)]
        public string Password { get; set; } = null!;

        [Required]
        [MaxLength(ValidationConstants.EmailMaxLength)]
        public string Email { get; set; } = null!;

        [Required]
        public decimal Balance { get; set; }

        public virtual ICollection<Bet> Bets { get; set; }
    }
}
