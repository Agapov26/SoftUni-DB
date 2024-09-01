using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static Invoices.Data.Models.DataConstraints;

namespace Invoices.Data.Models
{
    public class Client
    {
        [Key]
        public int Id { get; set; }

        [Required]
        [MaxLength(CLientNameMaxLength)]
        public string Name { get; set; } = null!;

        [Required]
        [MaxLength(NumberVatMaxLength)]
        public string NumberVat { get; set; } = null!;

        public virtual ICollection<Invoice> Invoices { get; set; }
            = new HashSet<Invoice>();

        public virtual ICollection<Adress> Adresses { get; set; }
            = new HashSet<Adress>();

        public virtual ICollection<ProductClient> ProductClients { get; set; }
            = new HashSet<ProductClient>();
    }
}
