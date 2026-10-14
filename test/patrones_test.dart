import 'package:appnoti/models/notificacion.dart';
import 'package:appnoti/services/adaptador_aviso.dart';
import 'package:appnoti/services/gestor_notificaciones.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Pruebas de patrones de diseño', () {
    late GestorNotificaciones gestor;

    setUp(() {
      gestor = GestorNotificaciones();

      gestor.limpiar();
    });

    // Comprueba que Singleton devuelve la misma instancia
    test('Singleton devuelve la misma instancia', () {
      final gestor1 = GestorNotificaciones();
      final gestor2 = GestorNotificaciones();

      // Verifica que ambos gestores sean exactamente el mismo objeto
      expect(identical(gestor1, gestor2), isTrue);
    });

    // Comprueba que las instancias comparten el registro
    test('El gestor centraliza las notificaciones', () {
      final fabrica = FabricaTarea();

      final tarea = fabrica.crear('Tarea de Dart', 'Entregar el ejercicio.');

      gestor.agregar(tarea);

      final otroGestor = GestorNotificaciones();

      expect(otroGestor.notificaciones.length, 1);

      expect(otroGestor.notificaciones.first.titulo, 'Tarea de Dart');
    });

    // Comprueba que Factory Method cree el tipo correcto
    test('Factory Method crea una notificación de examen', () {
      final fabrica = FabricaExamen();

      final examen = fabrica.crear('Examen parcial', 'Evaluación de patrones.');

      expect(examen, isA<NotificacionExamen>());

      expect(examen.tipo, 'Examen');

      expect(examen.prioridad, 'Alta');
    });

    // Comprueba que Adapter transforme los campos del sistema web
    test('Adapter convierte los campos del sistema web', () {
      final avisoWeb = <String, dynamic>{
        'asunto': 'Suspensión de clases',
        'contenido': 'Mañana no habrá clases.',
        'nivel': 'urgente',
      };

      final aviso = AdaptadorAviso().convertir(avisoWeb);

      expect(aviso, isA<NotificacionAviso>());

      expect(aviso.titulo, 'Suspensión de clases');

      expect(aviso.mensaje, 'Mañana no habrá clases.');

      expect(aviso.prioridad, 'Urgente');
    });

    // Comprueba que Adapter acepte el campo tituloAviso
    test('Adapter acepta el campo tituloAviso', () {
      final avisoWeb = <String, dynamic>{
        'tituloAviso': 'Becas disponibles',
        'contenido': 'Consulta la convocatoria.',
        'nivel': 'normal',
      };

      final aviso = AdaptadorAviso().convertir(avisoWeb);

      expect(aviso.titulo, 'Becas disponibles');

      expect(aviso.prioridad, 'normal');
    });

    // Comprueba que Adapter rechace los datos incompletos
    test('El Adapter rechaza datos incompletos', () {
      final avisoWeb = <String, dynamic>{'asunto': 'Aviso incompleto'};

      expect(() => AdaptadorAviso().convertir(avisoWeb), throwsFormatException);
    });
  });
}
