using System.Data.Entity;
using System.Data.Entity.Infrastructure;

namespace Sheremetov_UserRegistration.Model
{
    public partial class LibraryModelEntities : DbContext
    {
        public LibraryModelEntities()
            : base("name=LibraryModelEntities")
        {
        }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }

        public virtual DbSet<Authors> Authors { get; set; }
        public virtual DbSet<Books> Books { get; set; }
        public virtual DbSet<Issues> Issues { get; set; }
        public virtual DbSet<Readers> Readers { get; set; }
        public virtual DbSet<Roles> Roles { get; set; }
        public virtual DbSet<Users> Users { get; set; }
    }
}
