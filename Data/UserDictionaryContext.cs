using Microsoft.EntityFrameworkCore;
using UserDictionary.Models;

namespace UserDictionary.Data
{
    public class UserDictionaryContext : DbContext
    {
        public UserDictionaryContext (DbContextOptions<UserDictionaryContext> options)
            : base(options)
        {
        }

        public DbSet<UserDictionary.Models.User> User { get; set; }

        // add unique constraint 
        protected override void OnModelCreating(ModelBuilder builder)
        {
            builder.Entity<User>()
                .HasIndex(u => u.PostNumber)
                .IsUnique();
        }
    }
}
