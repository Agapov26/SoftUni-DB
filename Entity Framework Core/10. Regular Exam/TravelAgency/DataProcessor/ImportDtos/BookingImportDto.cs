using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TravelAgency.DataProcessor.ImportDtos
{
    public class BookingImportDto
    {
        public string BookingDate { get; set; }

        public string CustomerName { get; set; }

        public string TourPackageName { get; set; }
    }
}
