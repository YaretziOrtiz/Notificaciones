import '../../models/notificacion.dart';

// Clase que administra todas las notificaciones de la aplicación
class GestorNotificaciones {
  static final GestorNotificaciones _instancia =
      GestorNotificaciones._interno();

  // Constructor privado que impide crear instancias independientes
  GestorNotificaciones._interno();

  // Constructor de fábrica que devuelve siempre la misma instancia
  factory GestorNotificaciones() {
    return _instancia;
  }

  final List<Notificacion> _notificaciones = [];

  List<Notificacion> get notificaciones => List.unmodifiable(_notificaciones);

  void agregar(Notificacion notificacion) {
    _notificaciones.add(notificacion);
  }

  void limpiar() {
    _notificaciones.clear();
  }
}
