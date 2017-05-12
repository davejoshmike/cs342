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
    public class IncomeTaxController : ApiController
    {
        // ReSharper disable once InconsistentNaming
        private readonly PFContext db = new PFContext();

        // GET: api/IncomeTax
        [ResponseType(typeof(List<INCOMETAX>))]
        public async Task<IHttpActionResult> Get()
        {
            var incomeTaxList = new List<INCOMETAX>();
            await db.INCOMETAX.ForEachAsync(incomeTax => incomeTaxList.Add(incomeTax));
            return Ok(incomeTaxList);
        }

        // GET: api/IncomeTax/5
        [ResponseType(typeof(INCOMETAX))]
        public async Task<IHttpActionResult> Get(decimal id)
        {
            INCOMETAX incomeTax = await db.INCOMETAX.FindAsync(id);
            if (incomeTax == null)
            {
                return NotFound();
            }

            return Ok(incomeTax);
        }

        // PUT: api/IncomeTax/5
        [ResponseType(typeof(void))]
        public async Task<IHttpActionResult> Put(decimal id, INCOMETAX incomeTax)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != incomeTax.ID)
            {
                return BadRequest();
            }

            db.Entry(incomeTax).State = EntityState.Modified;

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (!IncomeTaxExists(id))
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

        // POST: api/IncomeTax
        [ResponseType(typeof(INCOMETAX))]
        public async Task<IHttpActionResult> Post(INCOMETAX incomeTax)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.INCOMETAX.Add(incomeTax);
            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (IncomeTaxExists(incomeTax.ID))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("PersonalFinanceApi", new { id = incomeTax.ID }, incomeTax);
        }

        // DELETE: api/IncomeTax/5
        [ResponseType(typeof(INCOMETAX))]
        public async Task<IHttpActionResult> Delete(decimal id)
        {
            INCOMETAX incomeTax = await db.INCOMETAX.FindAsync(id);
            if (incomeTax == null)
            {
                return NotFound();
            }
            db.INCOMETAX.Remove(incomeTax);
            await db.SaveChangesAsync();

            return Ok((INCOMETAX)incomeTax);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool IncomeTaxExists(decimal id)
        {
            return db.INCOMETAX.Count(e => e.ID == id) > 0;
        }
    }
}