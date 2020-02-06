using Microsoft.Data.SqlClient;
using System.Threading.Tasks;

namespace UserDictionary.Data
{
    public interface IDataRepository<T> where T : class
    {
        void Add(T entity);
        void AddBulk(T[] entities);
        void Update(T entity);
        void Delete(T entity);
        Task ExecuteStoredProcedure(string procName, SqlParameter[] parameters);
        Task<T> SaveAsync(T entity);
    }
}
