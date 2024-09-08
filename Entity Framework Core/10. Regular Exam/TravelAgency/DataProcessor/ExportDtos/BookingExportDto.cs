using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TravelAgency.DataProcessor.ExportDtos
{
    public class BookingExportDto
    {
        [JsonProperty(nameof(TourPackageName))]
        public string TourPackageName { get; set; }

        [JsonProperty(nameof(Date))]
        public string Date { get; set; }
    }
}
