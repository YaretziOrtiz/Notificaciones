import '../../models/notificacion.dart';

// Clase que adapta los datos del sistema web al formato de la aplicación
class AdaptadorAviso {
  Notificacion convertir(Map<String, dynamic> avisoWeb) {
    final titulo = avisoWeb['asunto'] ?? avisoWeb['tituloAviso'];

    final mensaje = avisoWeb['contenido'];

    final nivel = avisoWeb['nivel'];

    if (titulo == null || mensaje == null || nivel == null) {
      throw FormatException('El aviso web contiene campos incompletos.');
    }

    final prioridad = nivel.toString().toLowerCase() == 'urgente'
        ? 'Urgente'
        : nivel.toString();

    return NotificacionAviso(
      titulo: titulo.toString(),
      mensaje: mensaje.toString(),
      prioridad: prioridad,
    );
  }
}
