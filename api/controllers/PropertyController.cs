using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using api.dtos.property;
using api.interfaces;
using api.mappers;
using api.models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace api.controllers
{
    [Route("api/property")]
    [ApiController]
    public class PropertyController : ControllerBase
    {
        private readonly IPropertyRepository _propertyRepo;
        private readonly ILogger<PropertyController> _logger;
        public PropertyController(IPropertyRepository propertyRepo, ILogger<PropertyController> logger)
        {
            _propertyRepo = propertyRepo;
            _logger = logger;
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetPropertyAsync([FromRoute()] int id)
        {

            var property = await _propertyRepo.GetPropertyById(id);

            if (property == null) return NotFound();

            return Ok(property);
        }
        [HttpGet]
        public async Task<IActionResult> GetPropertiesAsync()
        {

            if (!ModelState.IsValid) return BadRequest(ModelState);

            var property = await _propertyRepo.GetProperties();

            if (property == null) return NotFound();

            return Ok(property);
        }
        [HttpPost]
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> CreatePropertiesAsync([FromBody()] PropertyDto propertyDto)
        {
            if (!ModelState.IsValid) return BadRequest(ModelState);

            try
            {

                var property = await _propertyRepo.CreateProperty(propertyDto);
                _logger.LogInformation("Property created successfully with ID {PropertyId}", property.Id);

                // return CreatedAtAction(nameof(GetPropertyAsync), new { id = property.Id }, property);
            return Ok(property);

            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while creating the property.");

                return StatusCode(500, "Internal server error");
            }
        }
        [HttpPut("{id}")]
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> UpdatePropertiesAsync([FromRoute] int id, [FromBody()] PropertyDto propertyDto)
        {

            if (!ModelState.IsValid) return BadRequest(ModelState);

            var property = await _propertyRepo.UpdateProperty(id, propertyDto);

            if (property == null)
            {
                return NotFound($"Property with ID {id} not found.");
            }


            return Ok(property);
        }
        [HttpDelete("{id}")]
        [Authorize(Roles = "ADMIN")]
        public async Task<IActionResult> DeletePropertiesAsync([FromRoute] int id)
        {

            if (!ModelState.IsValid) return BadRequest(ModelState);

            var property = await _propertyRepo.DeleteProperty(id);

            if (property == null) return NotFound();

            return NoContent();
        }
    }
}