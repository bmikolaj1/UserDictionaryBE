using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace UserDictionary.Data
{
    public class DataRepository<T> : IDataRepository<T> where T : class
    {
        private readonly UserDictionaryContext _context;

        public DataRepository(UserDictionaryContext context)
        {
            _context = context;
        }

        public void Add(T entity)
        {
            _context.Set<T>().Add(entity);
        }

        public void AddBulk(T[] entities)
        {
            _context.Set<T>().AddRange(entities);
        }

        public void Update(T entity)
        {
            _context.Set<T>().Update(entity);
        }

        public void Delete(T entity)
        {
            _context.Set<T>().Remove(entity);
        }  

        public async Task<T> SaveAsync(T entity)
        {
            await _context.SaveChangesAsync();
            return entity;
        }

        public async Task ExecuteStoredProcedure(string procName, SqlParameter[] parameters)
        {
            await _context.Database.ExecuteSqlRawAsync(procName, parameters);
        }
    }
}
