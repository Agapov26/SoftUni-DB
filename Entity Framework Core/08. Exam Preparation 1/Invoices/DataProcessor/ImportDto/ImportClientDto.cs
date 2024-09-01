using Invoices.Data.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;
using static Invoices.Data.Models.DataConstraints;

namespace Invoices.DataProcessor.ImportDto
{
    [XmlType(nameof(Client))]
    public class ImportClientDto
    {
        [XmlElement(nameof(Name))]
        [Required]
        [MinLength(CLientNameMinLength)]
        [MaxLength(CLientNameMaxLength)]
        public string Name { get; set; } = null!;

        [XmlElement(nameof(NumberVat))]
        [Required]
        [MinLength(NumberVatMinLength)]
        [MaxLength(NumberVatMaxLength)]
        public string NumberVat { get; set; } = null!;

        [XmlArray(nameof(Adresses))]
        public ImportAdressDto Adresses { get; set; } = null!;
    }
}
