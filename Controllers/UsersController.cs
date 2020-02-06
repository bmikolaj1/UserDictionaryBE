using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using UserDictionary.Data;
using UserDictionary.Models;

namespace UserDictionary.Controllers
{
    [Route("api/[controller]")]
    [Produces("application/json")]
    [ApiController]
    public class UsersController : ControllerBase
    {
        private readonly UserDictionaryContext _context;
        private readonly IDataRepository<User> _repository;

        public UsersController(UserDictionaryContext context, IDataRepository<User> repository)
        {
            _context = context;
            _repository = repository;
        }

        // GET: api/users
        [HttpGet]
        public async Task<ActionResult<IEnumerable<User>>> GetUsers()
        {
            return await _context.User.OrderByDescending(u => u.FirstName).ToListAsync();
        }

        // GET: api/users/5
        [HttpGet("{id}")]
        public async Task<IActionResult> GetUser([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var User = await _context.User.FindAsync(id);

            if (User == null)
            {
                return NotFound();
            }

            return Ok(User);
        }

        //// PUT: api/users/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutUser([FromRoute] int id, [FromBody] User user)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != user.Id)
            {
                return BadRequest();
            }

            _context.Entry(User).State = EntityState.Modified;

            try
            {
                _repository.Update(user);
                var save = await _repository.SaveAsync(user);
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!UserExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }



        // POST: api/users
        [HttpPost]
        public async Task<IActionResult> PostUser([FromBody] User[] users)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            foreach(User user in users)
            {         
                SqlParameter firstName = new SqlParameter("@FirstName", user.FirstName);
                SqlParameter lastName = new SqlParameter("@LastName", user.LastName);
                SqlParameter postNumber = new SqlParameter("@PostNumber", user.PostNumber);
                SqlParameter city = new SqlParameter("@City", user.City);
                SqlParameter telephone = new SqlParameter("@Telephone", user.Telephone);
                SqlParameter[] sqlParameters = { firstName, lastName, postNumber, city, telephone };
                try
                {
                    await _repository.ExecuteStoredProcedure("InsertProc @FirstName,@LastName,@PostNumber,@City,@Telephone", sqlParameters);
                }
                catch(SqlException ex)
                { 
                   return Content(ex.Message);
                }
                                
            }

            return Ok();
        }

        //// DELETE: api/users/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteUser([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var user = await _context.User.FindAsync(id);
            if (user == null)
            {
                return NotFound();
            }

            _repository.Delete(user);
            var save = await _repository.SaveAsync(user);

            return Ok(User);
        }

        private bool UserExists(int id)
        {
            return _context.User.Any(e => e.Id == id);
        }
    }
}
