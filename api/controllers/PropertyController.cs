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
    [Route("api/property")] // Define the base route for property-related API endpoints
    [ApiController] // Indicate that this class is an API controller
    public class PropertyController : ControllerBase
    {
        private readonly IPropertyRepository _propertyRepo; // Repository interface for property data operations
        private readonly ILogger<PropertyController> _logger; // Logger for logging events and errors

        // Constructor for dependency injection
        public PropertyController(IPropertyRepository propertyRepo, ILogger<PropertyController> logger)
        {
            _propertyRepo = propertyRepo; // Assign the property repository to the private field
            _logger = logger; // Assign the logger to the private field
        }

        // Endpoint to retrieve a specific property by ID
        [HttpGet("{id}")]
        public async Task<IActionResult> GetPropertyAsync([FromRoute()] int id)
        {
            // Fetch property details using the repository
            var property = await _propertyRepo.GetPropertyById(id);

            // Return a 404 Not Found response if the property does not exist
            if (property == null) return NotFound();

            // Return a 200 OK response with the property details
            return Ok(property);
        }

        // Endpoint to retrieve all properties
        [HttpGet]
        public async Task<IActionResult> GetPropertiesAsync()
        {
            // Validate the model state
            if (!ModelState.IsValid) return BadRequest(ModelState);

            // Fetch all properties using the repository
            var property = await _propertyRepo.GetProperties();

            // Return a 404 Not Found response if no properties exist
            if (property == null) return NotFound();

            // Return a 200 OK response with the list of properties
            return Ok(property);
        }

        // Endpoint to create a new property
        [HttpPost]
        // [Authorize(Roles = "Admin")] // Uncomment for role-based authorization
        public async Task<IActionResult> CreatePropertiesAsync([FromBody()] PropertyDto propertyDto)
        {
            // Validate the model state
            if (!ModelState.IsValid) return BadRequest(ModelState);

            try
            {
                // Create the property using the repository and log the creation event
                var property = await _propertyRepo.CreateProperty(propertyDto);
                _logger.LogInformation("Property created successfully with ID {PropertyId}", property.Id);

                // Return a 201 Created response with the location of the new resource
                // return CreatedAtAction(nameof(GetPropertyAsync), new { id = property.Id }, property);
                return Ok(property); // Return the created property for now
            }
            catch (Exception ex) // Catch any exceptions during property creation
            {
                // Log the error and return a 500 Internal Server Error response
                _logger.LogError(ex, "An error occurred while creating the property.");
                return StatusCode(500, "Internal server error");
            }
        }

        // Endpoint to update an existing property by ID
        [HttpPut("{id}")]
        // [Authorize(Roles = "Admin")] // Uncomment for role-based authorization
        public async Task<IActionResult> UpdatePropertiesAsync([FromRoute] int id, [FromBody()] PropertyDto propertyDto)
        {
            // Validate the model state
            if (!ModelState.IsValid) return BadRequest(ModelState);

            // Update the property using the repository
            var property = await _propertyRepo.UpdateProperty(id, propertyDto);

            // Return a 404 Not Found response if the property does not exist
            if (property == null)
            {
                return NotFound($"Property with ID {id} not found.");
            }

            // Return a 200 OK response with the updated property details
            return Ok(property);
        }

        // Endpoint to delete an existing property by ID
        [HttpDelete("{id}")]
        // [Authorize(Roles = "ADMIN")] // Uncomment for role-based authorization
        public async Task<IActionResult> DeletePropertiesAsync([FromRoute] int id)
        {
            // Validate the model state
            if (!ModelState.IsValid) return BadRequest(ModelState);

            // Delete the property using the repository
            var property = await _propertyRepo.DeleteProperty(id);

            // Return a 404 Not Found response if the property does not exist
            if (property == null) return NotFound();

            // Return a 204 No Content response indicating successful deletion
            return NoContent();
        }
    }
}