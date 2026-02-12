using examenDepEmpInsertRazorEF.Context;
using examenDepEmpInsertRazorEF.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace examenDepEmpInsertRazorEF.Controllers
{
    public class EmpleadoController : Controller
    {
        private readonly ExamenDepEmpInsertRazorEfContext _context;
        
        public EmpleadoController(ExamenDepEmpInsertRazorEfContext context)
        {
            _context = context;
        }
        public async Task<IActionResult> Index(int? id)
        {
            var _listaDeps = await _context.Departamentos.ToListAsync();
            List<Empleado> empleados = new();
            ViewBag.ListaDeptos = _listaDeps;
            ViewBag.IdSeleccionado = id;
            try
            {
                if (id > 0)
                {
                    empleados = await _context.Empleados.FromSqlRaw("exec sp_ListarEmpleadosPorDep {0}",id).ToListAsync();
                    
                }
                else
                {
                    empleados = await _context.Empleados.Include(nD => nD.IdDepartamentoNavigation).ToListAsync();
                }
                    return View(empleados);
            }
            catch (Exception ex)
            {
                return View(empleados);
            }
        }
        [HttpGet]
        public async Task<IActionResult> CrearEmpleado()
        {
            var _listaDeps = await _context.Departamentos.ToListAsync();
            ViewBag.ListaDeptos = _listaDeps;
            return View();
        }
        [HttpPost]
        public async Task<IActionResult> CrearEmpleado(Empleado empleado)
        {

            await _context.AddAsync(empleado);
            await _context.SaveChangesAsync();
            return RedirectToAction("Index");
        }
    }
}
