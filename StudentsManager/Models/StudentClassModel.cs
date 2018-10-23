using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace StudentsManager.Models
{
    public class StudentClassModel
    {
        [Required]
        public string ClassId { get; set; }

        [Required]
        public string StudId { get; set; }

        public string CreateAt { get; set; }

        public string UpdateAt { get; set; }
    }
}