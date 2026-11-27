using System.Collections.Generic;

namespace Sheremetov_UserRegistration.Model
{
    public partial class Authors
    {
        public Authors()
        {
            Books = new HashSet<Books>();
        }

        public int AuthorID { get; set; }
        public string FullName { get; set; }
        public string Country { get; set; }

        public virtual ICollection<Books> Books { get; set; }
    }

    public partial class Books
    {
        public Books()
        {
            Issues = new HashSet<Issues>();
        }

        public int BookID { get; set; }
        public string Title { get; set; }
        public int AuthorID { get; set; }
        public int? PublicationYear { get; set; }
        public decimal? Price { get; set; }

        public virtual Authors Author { get; set; }
        public virtual ICollection<Issues> Issues { get; set; }
    }

    public partial class Issues
    {
        public int IssueID { get; set; }
        public int BookID { get; set; }
        public int ReaderID { get; set; }
        public System.DateTime IssueDate { get; set; }
        public System.DateTime? ReturnDate { get; set; }

        public virtual Books Book { get; set; }
        public virtual Readers Reader { get; set; }
    }

    public partial class Readers
    {
        public Readers()
        {
            Issues = new HashSet<Issues>();
            Users = new HashSet<Users>();
        }

        public int ReaderID { get; set; }
        public string FullName { get; set; }
        public System.DateTime? RegistrationDate { get; set; }

        public virtual ICollection<Issues> Issues { get; set; }
        public virtual ICollection<Users> Users { get; set; }
    }

    public partial class Roles
    {
        public Roles()
        {
            Users = new HashSet<Users>();
        }

        public int RoleID { get; set; }
        public string Name { get; set; }

        public virtual ICollection<Users> Users { get; set; }
    }

    public partial class Users
    {
        public int UserID { get; set; }
        public string Login { get; set; }
        public string PasswordHash { get; set; }
        public int RoleID { get; set; }
        public int? ReaderID { get; set; }
        public System.DateTime CreatedAt { get; set; }

        public virtual Readers Reader { get; set; }
        public virtual Roles Role { get; set; }
    }
}
