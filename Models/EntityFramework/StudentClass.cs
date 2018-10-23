namespace Models.EntityFramework
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("StudentClass")]
    public partial class StudentClass
    {
        [Key]
        [Column(Order = 0)]
        [StringLength(20)]
        public string ClassId { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(20)]
        public string StudId { get; set; }

        public DateTime CreateAt { get; set; }

        public DateTime UpdateAt { get; set; }

        public virtual Class Class { get; set; }

        public virtual Student Student { get; set; }
    }
}
