namespace Models.EntityFramework
{
    using System.ComponentModel.DataAnnotations;

    public partial class User
    {
        [Key]
        [StringLength(50)]
        public string UserName { get; set; }

        [Required]
        [StringLength(50)]
        public string Password { get; set; }

        [StringLength(150)]
        public string Email { get; set; }

        public bool isActive { get; set; }
    }
}
