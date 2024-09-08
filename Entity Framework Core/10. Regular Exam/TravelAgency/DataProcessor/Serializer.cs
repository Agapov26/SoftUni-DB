using Newtonsoft.Json;
using System.Text;
using System.Xml.Serialization;
using TravelAgency.Data;
using TravelAgency.Data.Models.Enums;
using TravelAgency.DataProcessor.ExportDtos;
using TravelAgency.Helper;

namespace TravelAgency.DataProcessor
{
    public class Serializer
    {
        public static string ExportGuidesWithSpanishLanguageWithAllTheirTourPackages(TravelAgencyContext context)
        {
            var guides = context.Guides.Where(g => g.Language == (Language)3)
            .Select(g => new GuideExportDto
            {
                FullName = g.FullName,
                TourPackages = g.TourPackagesGuides
                .Select(tpg => new TourPackageExportDto
                {
                    Name = tpg.TourPackage.PackageName,
                    Description = tpg.TourPackage.Description,
                    Price = tpg.TourPackage.Price
                })
                .OrderByDescending(tp => tp.Price)
                .ThenBy(tp => tp.Name)
                .ToList()
        })

        .OrderByDescending(g => g.TourPackages.Count)
        .ThenBy(g => g.FullName)
        .ToList();

            return XmlSeralizationHelper.Serialize(guides, "Guides");
        }

        public static string ExportCustomersThatHaveBookedHorseRidingTourPackage(TravelAgencyContext context)
        {
            var customer = context.Customers.Where(c => c.Bookings.Any(b => b.TourPackage.PackageName == "Horse Riding Tour"))
            .Select(c => new CustomerExportDto
            {
                FullName = c.FullName,
                PhoneNumber = c.PhoneNumber,
                Bookings = c.Bookings
                .Where(b => b.TourPackage.PackageName == "Horse Riding Tour")
                .Select(b => new BookingExportDto
                {
                    TourPackageName = b.TourPackage.PackageName,
                    Date = b.BookingDate.ToString("yyyy-MM-dd")
                })

                .OrderBy(b => b.Date)
                .ToList()
            })

            .OrderByDescending(c => c.Bookings.Count)
            .ThenBy(c => c.FullName)
            .ToList();

            return JsonConvert.SerializeObject(customer);
        }
    }
}
