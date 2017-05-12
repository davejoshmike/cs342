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
    public class IncomeTaxBracketController : ApiController
    {
        // ReSharper disable once InconsistentNaming
        private readonly PFContext db = new PFContext();

        // GET: api/IncomeTaxBracket
        [ResponseType(typeof(List<INCOMETAXBRACKET>))]
        public async Task<IHttpActionResult> Get()
        {
            var incomeTaxBracketList = new List<INCOMETAXBRACKET>();
            await db.INCOMETAXBRACKET.ForEachAsync(incomeTaxBracket => incomeTaxBracketList.Add(incomeTaxBracket));
            return Ok(incomeTaxBracketList);
        }

        // GET: api/IncomeTaxBracket/5
        
        [ResponseType(typeof(INCOMETAXBRACKET))]
        [Route("api/IncomeTaxBracket/{id}/{bracketLevel}")]
        public async Task<IHttpActionResult> Get(decimal id, decimal bracketLevel)
        {
            INCOMETAXBRACKET incomeTaxBracket = await db.INCOMETAXBRACKET.FindAsync(id, bracketLevel);
            if (incomeTaxBracket == null)
            {
                return NotFound();
            }

            return Ok(incomeTaxBracket);
        }

        // PUT: api/IncomeTaxBracket/5
        [ResponseType(typeof(void))]
        [Route("api/IncomeTaxBracket/{id}/{bracketLevel}")]
        public async Task<IHttpActionResult> Put(decimal id, decimal bracketLevel, INCOMETAXBRACKET incomeTaxBracket)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != incomeTaxBracket.ID || bracketLevel != incomeTaxBracket.BRACKETLEVEL)
            {
                return BadRequest();
            }

            db.Entry(incomeTaxBracket).State = EntityState.Modified;

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (!IncomeTaxBracketExists(id, bracketLevel))
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

        // POST: api/IncomeTaxBracket
        [ResponseType(typeof(INCOMETAXBRACKET))]
        public async Task<IHttpActionResult> Post(INCOMETAXBRACKET incomeTaxBracket)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.INCOMETAXBRACKET.Add(incomeTaxBracket);
            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (IncomeTaxBracketExists(incomeTaxBracket.ID, incomeTaxBracket.BRACKETLEVEL))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("PersonalFinanceApi", new { id = incomeTaxBracket.ID, incomeTaxBracket.BRACKETLEVEL }, incomeTaxBracket);
        }

        // DELETE: api/IncomeTaxBracket/5
        [ResponseType(typeof(INCOMETAXBRACKET))]
        [Route("api/IncomeTaxBracket/{id}/{bracketLevel}")]
        public async Task<IHttpActionResult> Delete(decimal id, decimal bracketLevel)
        {
            INCOMETAXBRACKET incomeTaxBracket = await db.INCOMETAXBRACKET.FindAsync(id, bracketLevel);
            if (incomeTaxBracket == null)
            {
                return NotFound();
            }
            db.INCOMETAXBRACKET.Remove(incomeTaxBracket);
            await db.SaveChangesAsync();

            return Ok(incomeTaxBracket);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool IncomeTaxBracketExists(decimal id, decimal bracketLevel)
        {
            return db.INCOMETAXBRACKET.Count(e => e.ID == id && e.BRACKETLEVEL == bracketLevel) > 0;
        }
    }
}