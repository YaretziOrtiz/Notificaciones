import 'package:flutter/material.dart';
import 'models/notificacion.dart';
import 'services/gestor_notificaciones.dart';
import 'services/adaptador_aviso.dart';

void main() {
  runApp(const AplicacionUniversitaria());
}

// Clase principal de la aplicación
class AplicacionUniversitaria extends StatelessWidget {
  const AplicacionUniversitaria({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Notificaciones Universitarias',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),

      home: const PantallaNotificaciones(),
    );
  }
}

// Pantalla que permite crear y consultar las notificaciones
class PantallaNotificaciones extends StatefulWidget {
  const PantallaNotificaciones({super.key});

  // Crea el estado que controla los cambios de la pantalla
  @override
  State<PantallaNotificaciones> createState() => _PantallaNotificacionesState();
}

// Clase que administra el comportamiento de la pantalla
class _PantallaNotificacionesState extends State<PantallaNotificaciones> {
  final GestorNotificaciones gestor = GestorNotificaciones();

  void crearNotificacion(FabricaNotificacion fabrica) {
    final notificacion = fabrica.crear(
      switch (fabrica) {
        FabricaTarea() => 'Nueva tarea',
        FabricaExamen() => 'Próximo examen',
        _ => 'Aviso universitario',
      },

      switch (fabrica) {
        FabricaTarea() => 'Se asignó una actividad nueva.',
        FabricaExamen() => 'Se aproxima una evaluación.',
        _ => 'Consulta la información publicada.',
      },
    );

    setState(() {
      gestor.agregar(notificacion);
    });
  }

  // Importa un aviso de ejemplo proveniente del sistema web
  void importarAvisoWeb() {
    final avisoWeb = <String, dynamic>{
      'asunto': 'Suspensión de clases',
      'contenido': 'Mañana no habrá clases.',
      'nivel': 'urgente',
    };

    final adaptador = AdaptadorAviso();

    final notificacion = adaptador.convertir(avisoWeb);

    setState(() {
      gestor.agregar(notificacion);
    });
  }

  Color colorPrioridad(String prioridad) {
    switch (prioridad.toLowerCase()) {
      case 'urgente':
        return Colors.red;

      case 'alta':
        return Colors.orange;

      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    final notificaciones = gestor.notificaciones;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificaciones universitarias'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(
                  onPressed: () => crearNotificacion(FabricaTarea()),
                  child: const Text('Crear tarea'),
                ),

                ElevatedButton(
                  onPressed: () => crearNotificacion(FabricaExamen()),
                  child: const Text('Crear examen'),
                ),

                ElevatedButton(
                  onPressed: () => crearNotificacion(FabricaAviso()),
                  child: const Text('Crear aviso'),
                ),

                ElevatedButton(
                  onPressed: importarAvisoWeb,
                  child: const Text('Importar aviso web'),
                ),
              ],
            ),
          ),

          const Divider(),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              'Notificaciones registradas: ${notificaciones.length}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),

          Expanded(
            child: notificaciones.isEmpty
                ? const Center(child: Text('No hay notificaciones.'))
                : ListView.builder(
                    itemCount: notificaciones.length,

                    itemBuilder: (context, index) {
                      final n = notificaciones[index];

                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 5,
                        ),
                        child: ListTile(
                          leading: Icon(
                            Icons.notifications_active,
                            color: colorPrioridad(n.prioridad),
                          ),

                          title: Text(n.titulo),

                          subtitle: Text('${n.tipo}\n${n.mensaje}'),

                          isThreeLine: true,

                          trailing: Text(
                            n.prioridad,
                            style: TextStyle(
                              color: colorPrioridad(n.prioridad),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: OutlinedButton.icon(
              onPressed: () {
                setState(() {
                  gestor.limpiar();
                });
              },

              icon: const Icon(Icons.delete_outline),

              label: const Text('Limpiar notificaciones'),
            ),
          ),
        ],
      ),
    );
  }
}
