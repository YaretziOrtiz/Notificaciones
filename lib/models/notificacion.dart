// Clase abstracta que define la estructura general de una notificación
abstract class Notificacion {
  final String titulo;

  final String mensaje;

  final String prioridad;

  Notificacion({
    required this.titulo,
    required this.mensaje,
    required this.prioridad,
  });

  String get tipo;

  @override
  String toString() {
    return '$tipo | $titulo | $mensaje | Prioridad: $prioridad';
  }
}

// Clase que representa una notificación de tarea
class NotificacionTarea extends Notificacion {
  NotificacionTarea({
    required super.titulo,
    required super.mensaje,
    super.prioridad = 'Normal',
  });

  @override
  String get tipo => 'Tarea';
}

// Clase que representa una notificación de examen
class NotificacionExamen extends Notificacion {
  NotificacionExamen({
    required super.titulo,
    required super.mensaje,
    super.prioridad = 'Alta',
  });

  @override
  String get tipo => 'Examen';
}

// Clase que representa una notificación de aviso universitario
class NotificacionAviso extends Notificacion {
  NotificacionAviso({
    required super.titulo,
    required super.mensaje,
    super.prioridad = 'Normal',
  });

  @override
  String get tipo => 'Aviso';
}

// Clase abstracta que define el método para crear notificaciones
abstract class FabricaNotificacion {
  Notificacion crear(String titulo, String mensaje);
}

// Fábrica encargada de crear notificaciones de tareas
class FabricaTarea extends FabricaNotificacion {
  @override
  Notificacion crear(String titulo, String mensaje) {
    return NotificacionTarea(titulo: titulo, mensaje: mensaje);
  }
}

// Fábrica encargada de crear notificaciones de exámenes
class FabricaExamen extends FabricaNotificacion {
  @override
  Notificacion crear(String titulo, String mensaje) {
    return NotificacionExamen(titulo: titulo, mensaje: mensaje);
  }
}

// Fábrica encargada de crear notificaciones de avisos
class FabricaAviso extends FabricaNotificacion {
  @override
  Notificacion crear(String titulo, String mensaje) {
    return NotificacionAviso(titulo: titulo, mensaje: mensaje);
  }
}
