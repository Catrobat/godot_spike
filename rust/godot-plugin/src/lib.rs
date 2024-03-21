use godot::engine::Engine;
use godot::prelude::*;

// Register this plugin as a Godot Extension
struct MyExtension {}

#[gdextension]
unsafe impl ExtensionLibrary for MyExtension {
    fn on_level_init(level: InitLevel) {
        if level == InitLevel::Scene {
            Engine::singleton()
                .register_singleton(StringName::from("API"), Api::new_alloc().upcast());
        }
    }

    fn on_level_deinit(level: InitLevel) {
        if level == InitLevel::Scene {
            let mut engine = Engine::singleton();
            let singleton_name = StringName::from("API");
            let singleton = engine
                .get_singleton(singleton_name.clone())
                .expect("cannot retrieve the engine singleton");

            engine.unregister_singleton(singleton_name);
            singleton.free();
        }
    }
}

// Implementation of the API
#[derive(GodotClass)]
#[class(base=Object, init)]
struct Api {}

#[godot_api]
impl Api {
    #[func]
    fn damage(x: i64) -> i64 {
        x + 42
    }

    #[func]
    fn get_name() -> GString {
        "Henlo".into()
    }

    #[func]
    fn add() -> i64 {
        compiler::add(2, 2) as i64
    }
}
