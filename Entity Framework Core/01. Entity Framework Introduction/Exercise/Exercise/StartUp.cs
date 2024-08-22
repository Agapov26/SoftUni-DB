using SoftUni.Data;
using System.Text;

namespace Exercise
{
    public class StartUp
    {
        public static void Main(string[] args)
        {
            static void Main(string[] args)
            {
                using (var context = new SoftUniContext())
                {
                    Console.WriteLine(GetLatestProjects(context));
                }
            }

            static string GetEmployeesFullInformation(SoftUniContext context)
            {
                return string.Join(Environment.NewLine, context.Employees
                    .Select(e => $"{e.FirstName} {e.LastName} {e.MiddleName} {e.JobTitle} {e.Salary:f2}"));
            }

            static string GetEmployeesWithSalaryOver50000(SoftUniContext context)
            {
                var employees = context.Employees
                    .Select(e => new
                    {
                        e.FirstName,
                        e.Salary
                    })
                    .Where(e => e.Salary > 50000)
                    .OrderBy(e => e.FirstName);

                return string.Join(Environment.NewLine, employees
                    .Select(e => $"{e.FirstName} - {e.Salary:f2}"));
            }

            static string GetEmployeesFromResearchAndDevelopment(SoftUniContext context)
            {
                var employees = context.Employees
                    .Select(e => new
                    {
                        e.FirstName,
                        e.LastName,
                        e.Department,
                        e.Salary
                    })
                    .Where(e => e.Department.Name == "Research and Development")
                    .OrderBy(e => e.Salary)
                    .ThenByDescending(e => e.FirstName);

                return string.Join(Environment.NewLine, employees
                    .Select(e => $"{e.FirstName} {e.LastName} from {e.Department.Name} - ${e.Salary:f2}"));
            }

            static string AddNewAddressToEmployee(SoftUniContext context)
            {
                Address address = new Address()
                {
                    AddressText = "Vitoshka 15",
                    TownId = 4
                };

                var employee = context.Employees
                    .FirstOrDefault(e => e.LastName == "Nakov");

                if (employee != null)
                {
                    employee.Address = address;
                    context.SaveChanges();
                }

                var employees = context.Employees
                    .OrderByDescending(e => e.AddressId)
                    .Take(10)
                    .Select(e => e.Address.AddressText);

                return string.Join(Environment.NewLine, employees);
            }

            static string GetEmployeesInPeriod(SoftUniContext context)
            {
                var employees = context.Employees
                    .Take(10)
                    .Select(e => new
                    {
                        EmployeeName = $"{e.FirstName} {e.LastName}",
                        ManagerName = $"{e.Manager.FirstName} {e.Manager.LastName}",
                        Projects = e.EmployeesProjects
                            .Where(ep =>
                            ep.Project.StartDate.Year >= 2001 &&
                            ep.Project.StartDate.Year <= 2003)
                            .Select(ep => new
                            {
                                ep.Project.Name,
                                StartDate = ep.Project.StartDate.ToString("M/d/yyyy h:mm:ss tt"),
                                EndDate = ep.Project.EndDate.HasValue ?
                                    ep.Project.EndDate.Value.ToString("M/d/yyyy h:mm:ss tt") :
                                    "not finished"
                            })
                    });

                StringBuilder sb = new StringBuilder();

                foreach (var employee in employees)
                {
                    sb.AppendLine($"{employee.EmployeeName} - Manager: {employee.ManagerName}");

                    foreach (var project in employee.Projects)
                    {
                        sb.AppendLine($"--{project.Name} - {project.StartDate} - {project.EndDate}");
                    }
                }

                return sb.ToString().TrimEnd();
            }

            static string GetAddressesByTown(SoftUniContext context)
            {
                var addresses = context.Addresses
                    .Select(a => new
                    {
                        a.AddressText,
                        TownName = a.Town.Name,
                        EmployeesCount = a.Employees.Count
                    })
                    .OrderByDescending(a => a.EmployeesCount)
                    .ThenBy(a => a.TownName)
                    .ThenBy(a => a.AddressText)
                    .Take(10);


                StringBuilder sb = new StringBuilder();
                foreach (var address in addresses)
                {
                    sb.AppendLine($"{address.AddressText}, {address.TownName} - {address.EmployeesCount} employees");
                }

                return sb.ToString().TrimEnd();
            }

            static string GetEmployee147(SoftUniContext context)
            {
                var employee = context.Employees
                    .Select(e => new
                    {
                        e.EmployeeId,
                        e.FirstName,
                        e.LastName,
                        e.JobTitle,
                        Projects = e.EmployeesProjects
                            .Select(ep => new
                            {
                                ep.Project.Name
                            })
                            .OrderBy(p => p.Name)
                            .ToList()
                    })
                    .Where(e => e.EmployeeId == 147)
                    .FirstOrDefault();

                StringBuilder sb = new StringBuilder();
                sb.AppendLine($"{employee.FirstName} {employee.LastName} - {employee.JobTitle}");

                foreach (var project in employee.Projects)
                {
                    sb.AppendLine(project.Name);
                }

                return sb.ToString().TrimEnd();
            }

            static string GetDepartmentsWithMoreThan5Employees(SoftUniContext context)
            {
                var departments = context.Departments
                    .Where(d => d.Employees.Count > 5)
                    .OrderBy(d => d.Employees.Count)
                    .ThenBy(d => d.Name)
                    .Select(d => new
                    {
                        d.Name,
                        ManagerName = $"{d.Manager.FirstName} {d.Manager.LastName}",
                        Emplyoees = d.Employees
                            .Select(e => new
                            {
                                e.FirstName,
                                e.LastName,
                                e.JobTitle
                            })
                            .OrderBy(e => e.FirstName)
                            .ThenBy(e => e.LastName)
                            .ToList()
                    });


                StringBuilder sb = new StringBuilder();

                foreach (var department in departments)
                {
                    sb.AppendLine($"{department.Name} - {department.ManagerName}");

                    foreach (var employee in department.Emplyoees)
                    {
                        sb.AppendLine($"{employee.FirstName} {employee.LastName} - {employee.JobTitle}");
                    }
                }

                return sb.ToString().TrimEnd();
            }

            static string GetLatestProjects(SoftUniContext context)
            {
                var projects = context.Projects
                    .Take(10)
                    .Select(p => new
                    {
                        p.Name,
                        p.Description,
                        p.StartDate
                    })
                    .OrderBy(p => p.Name);

                StringBuilder sb = new StringBuilder();

                foreach (var project in projects)
                {
                    sb.AppendLine(project.Name +
                        Environment.NewLine +
                        project.Description +
                        Environment.NewLine +
                        project.StartDate.ToString("M/d/yyyy h:mm:ss tt"));
                }

                return sb.ToString().TrimEnd();
            }
        }
    }
}