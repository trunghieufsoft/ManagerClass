using Models.EntityFramework;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace StudentsManager.Models
{
    public class StudentsModel
    {
        [Required]
        public string StudId { get; set; }

        [Required]
        public string FullName { get; set; }

        public bool Gender { get; set; }
        
        [Required]
        public string BirthDay { get; set; }
        
        public string Address { get; set; }

        [StringLength(12)]
        public string Phone { get; set; }

        public string CreateAt { get; set; }

        public string UpdateAt { get; set; }

        public Tuple<int, List<StudentsModel>> SetListStudentModel(List<Student> listStudent)
        {
            var data = new List<StudentsModel>();
            foreach (var item in listStudent)
            {
                var obj = new StudentsModel()
                {
                    StudId = item.StudId,
                    FullName = item.FullName,
                    Address = item.Address,
                    BirthDay = item.BirthDay.ToString("dd/MM/yyyy"),
                    Gender = item.Gender,
                    Phone = item.Phone,
                    CreateAt = item.CreateAt.ToString("dd/MM/yyyy"),
                    UpdateAt = item.UpdateAt.ToString("dd/MM/yyyy")
                };
                data.Add(obj);
            }
            return Tuple.Create(data.Count, data);
        }
    }
}