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
    public class WageController : ApiController
    {
        // ReSharper disable once InconsistentNaming
        private readonly PFContext db = new PFContext();

        // GET: api/Wage
        [ResponseType(typeof(List<WAGE>))]
        public async Task<IHttpActionResult> Get()
        {
            var wageList = new List<WAGE>();
            await db.WAGE.ForEachAsync(wage => wageList.Add(wage));
            return Ok(wageList);
        }

        // GET: api/Wage/5
        [ResponseType(typeof(WAGE))]
        public async Task<IHttpActionResult> Get(decimal personid)
        {
            WAGE wage = await db.WAGE.FindAsync(personid);
            if (wage == null)
            {
                return NotFound();
            }

            return Ok(wage);
        }

        // PUT: api/Wage/5
        [ResponseType(typeof(void))]
        public async Task<IHttpActionResult> Put(decimal personid, WAGE wage)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (personid != wage.PERSONID)
            {
                return BadRequest();
            }

            db.Entry(wage).State = EntityState.Modified;

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (!WageExists(personid))
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

        // POST: api/Wage
        [ResponseType(typeof(WAGE))]
        public async Task<IHttpActionResult> Post(WAGE wage)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.WAGE.Add(wage);
            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (WageExists(wage.PERSONID))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("PersonalFinanceApi", new { personid = wage.PERSONID }, wage);
        }

        // DELETE: api/Wage/5
        [ResponseType(typeof(WAGE))]
        public async Task<IHttpActionResult> Delete(decimal personid)
        {
            WAGE wage = await db.WAGE.FindAsync(personid);
            if (wage == null)
            {
                return NotFound();
            }
            db.WAGE.Remove(wage);
            await db.SaveChangesAsync();

            return Ok((WAGE)wage);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool WageExists(decimal personid)
        {
            return db.WAGE.Count(e => e.PERSONID == personid) > 0;
        }
    }
}