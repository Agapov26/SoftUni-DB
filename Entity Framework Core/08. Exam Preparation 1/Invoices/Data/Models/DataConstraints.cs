using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Invoices.Data.Models
{
    public class DataConstraints
    {
        //Product
        public const byte ProductNameMinLength = 9;
        public const byte ProductNameMaxLength = 30;
        public const string ProductPriceMinValue = "5.00";
        public const string ProductPriceMaxValue = "1000.00";

        //Adress
        public const byte AdressStreetNameMinLength = 10;
        public const byte AdressStreetNameMaxLength = 20;
        public const byte AdressCityMinLength = 5;
        public const byte AdressCityMaxLength = 15;
        public const byte AdressCountryMinLength = 5;
        public const byte AdressCountryMaxLength = 15;

        //Invoice
        public const int InvoiceNumberMinValue = 1_000_000_000;
        public const int InvoiceNumberMaxValue = 1_500_000_000;

        //Client
        public const byte CLientNameMinLength = 10;
        public const byte CLientNameMaxLength = 25;
        public const byte NumberVatMinLength = 10;
        public const byte NumberVatMaxLength = 15;
    }
}
