namespace Models.EntityFramework
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Student
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Student()
        {
            StudentClasses = new HashSet<StudentClass>();
        }

        [Key]
        [StringLength(20)]
        public string StudId { get; set; }

        [Required]
        [StringLength(50)]
        public string FullName { get; set; }

        public bool Gender { get; set; }

        [Required]
        [Column(TypeName = "date")]
        public DateTime BirthDay { get; set; }

        [Column(TypeName = "ntext")]
        public string Address { get; set; }
        
        [StringLength(12)]
        public string Phone { get; set; }

        public DateTime CreateAt { get; set; }

        public DateTime UpdateAt { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<StudentClass> StudentClasses { get; set; }
    }
}
