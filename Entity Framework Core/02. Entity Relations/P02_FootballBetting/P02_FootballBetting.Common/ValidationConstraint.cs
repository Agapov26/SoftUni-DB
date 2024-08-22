using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace P02_FootballBetting.Common
{
    public class ValidationConstraint
    {
        public const int UsernameMaxLength = 36;

        public const int NameMaxLength = 100;

        public const int PasswordMaxLength = 24;

        public const int EmailMaxLength = 254;

        public const int TownNameMaxLength = 70;

        public const int CountryNameMaxLength = 70;

        public const int TeamNameMaxLength = 24;

        public const int TeamInitialsMinLength = 3;

        public const int TeamInitialsMaxLength = 3;

        public const int PositionNameMaxLength = 50;

        public const int BetPredictionMaxLength = 50;

        public const int ColorNameMaxLength = 24;
    }
}
