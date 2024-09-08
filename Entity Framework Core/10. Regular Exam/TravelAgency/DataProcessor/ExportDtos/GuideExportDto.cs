using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;
using TravelAgency.Data.Models;

namespace TravelAgency.DataProcessor.ExportDtos
{
    [XmlType(nameof(Guide))]
    public class GuideExportDto
    {
        public string FullName { get; set; }

        public List<TourPackageExportDto> TourPackages { get; set; }
    }
}
