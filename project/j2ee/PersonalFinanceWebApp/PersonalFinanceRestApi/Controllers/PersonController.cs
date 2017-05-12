using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using System.Web.Http;
using System.Web.Http.Description;
using PersonalFinanceRestApi.Models;

namespace PersonalFinanceRestApi.Controllers
{
    public class PersonController : ApiController
    {
        // ReSharper disable once InconsistentNaming
        private readonly PFContext db = new PFContext();    

        // GET: api/Person
        [ResponseType(typeof(List<PERSON>))]
        public async Task<IHttpActionResult> Get()
        {
            var personList = new List<PERSON>();
            await db.PERSON.ForEachAsync(person => personList.Add((PERSON)person));
            return Ok(personList);
        }

        // GET: api/Person/5
        [ResponseType(typeof(PERSON))]
        public async Task<IHttpActionResult> Get(decimal id)
        {
            PERSON person = await db.PERSON.FindAsync(id);
            if (person == null)
            {
                return NotFound();
            }
            
            return Ok(person);
        }

        // PUT: api/Person/5
        [ResponseType(typeof(void))]
        public async Task<IHttpActionResult> Put(decimal id, PERSON person)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != person.ID)
            {
                return BadRequest();
            }

            db.Entry(person).State = EntityState.Modified;

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (!PersonExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return StatusCode(HttpStatusCode.NoContent);
        }

        // POST: api/Person
        [ResponseType(typeof(PERSON))]
        public async Task<IHttpActionResult> Post(PERSON person)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.PERSON.Add(person);
            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (PersonExists(person.ID))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("PersonalFinanceApi", new {id = person.ID }, person);
        }

        // DELETE: api/Person/5
        [ResponseType(typeof(PERSON))]
        public async Task<IHttpActionResult> Delete(decimal id)
        {
            PERSON person = await db.PERSON.FindAsync(id);
            if (person == null)
            {
                return NotFound();
            }
            db.PERSON.Remove(person);
            await db.SaveChangesAsync();

            return Ok((PERSON)person);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool PersonExists(decimal id)
        {
            return db.PERSON.Count(e => e.ID == id) > 0;
        }
    }
}