using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static Invoices.Data.Models.DataConstraints;

namespace Invoices.Data.Models
{
    public class Adress
    {
        [Key]
        public int Id { get; set; }

        [Required]
        [MaxLength(AdressStreetNameMaxLength)]
        public string StreetName { get; set; } = null!;

        [Required]
        public int ReadNumber { get; set; }

        [Required]
        public string PostCode { get; set; } = null!;

        [Required]
        [MaxLength(AdressCityMaxLength)]
        public string City { get; set; } = null!;

        [Required]
        [MaxLength(AdressCountryMaxLength)]
        public string Country { get; set; } = null!;

        [Required]
        [ForeignKey(nameof(Client))]
        public int ClientId { get; set; }

        [Required]
        public virtual Client Client { get; set; } = null!;
    }
}
