using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Invoices.DataProcessor.ImportDto
{
    public class ImportInvoiceDto
    {
        [Required]
        public int Number { get; set; }
        public string IssueDate { get; set; }
        public string DueDate { get; set; } 
        public decimal Amount { get; set; }
        public int CurrencyType { get; set; }
        public int ClientId { get; set; }


    }
}
