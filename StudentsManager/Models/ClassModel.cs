using Models.EntityFramework;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace StudentsManager.Models
{
    public class ClassModel
    {
        public string ClassId { get; set; }
        
        public string ClassName { get; set; }

        public int StudTotal { get; set; }
        
        public string CreateAt { get; set; }

        public string UpdateAt { get; set; }

        public Tuple<int, List<ClassModel>> SetListClassModel(List<Class> listClass)
        {
            var data = new List<ClassModel>();
            foreach (var item in listClass)
            {
                var obj = new ClassModel()
                {
                    ClassId = item.ClassId,
                    ClassName = item.ClassName,
                    StudTotal = item.StudTotal,
                    CreateAt = item.CreateAt.ToString("dd/MM/yyyy"),
                    UpdateAt = item.UpdateAt.ToString("dd/MM/yyyy")
                };
                data.Add(obj);
            }
            return Tuple.Create(data.Count, data);
        }
    }
}