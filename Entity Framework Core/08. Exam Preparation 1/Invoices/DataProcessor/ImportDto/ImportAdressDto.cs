using Invoices.Data.Models;
using Newtonsoft.Json;
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
    [XmlType(nameof(Adress))]
    public class ImportAdressDto
    {
        [XmlElement(nameof(StreetName))]
        [Required]
        [MinLength(AdressStreetNameMinLength)]
        [MaxLength(AdressStreetNameMaxLength)]
        public string StreetName { get; set; } = null!;

        [XmlElement(nameof(StreetNumber))]
        [Required]
        public int StreetNumber { get; set; }

        [XmlElement(nameof(PostCode))]
        [Required]
        public string PostCode { get; set; } = null!;

        [XmlElement(nameof(City))]
        [Required]
        [MinLength(AdressCityMinLength)]
        [MaxLength(AdressCityMaxLength)]
        public string City { get; set; } = null!;

        [XmlElement(nameof(Country))]
        [Required]
        [MinLength(AdressCountryMinLength)]
        [MaxLength(AdressCountryMaxLength)]
        public string Country { get; set; } = null!;
    }
}
