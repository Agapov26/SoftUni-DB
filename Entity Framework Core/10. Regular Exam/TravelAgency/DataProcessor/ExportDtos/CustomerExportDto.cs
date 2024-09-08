using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TravelAgency.DataProcessor.ImportDtos;

namespace TravelAgency.DataProcessor.ExportDtos
{
    public class CustomerExportDto
    {
        [JsonProperty(nameof(FullName))]
        public string FullName { get; set; }

        [JsonProperty(nameof(PhoneNumber))]
        public string PhoneNumber { get; set; }

        [JsonProperty(nameof(Bookings))]
        public List<BookingExportDto> Bookings { get; set; }
    }
}
