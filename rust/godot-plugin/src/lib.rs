use godot::engine::Engine;
use godot::prelude::*;

use std::sync::{Mutex, OnceLock};

// Register this plugin as a Godot Extension
struct MyExtension {}

fn ast() -> &'static Mutex<Vec<i64>> {
    static AST: OnceLock<Mutex<Vec<i64>>> = OnceLock::new();
    AST.get_or_init(|| Mutex::new(vec![]))
}

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
    fn insert(x: i64) {
        ast().lock().unwrap().push(x);
    }

    #[func]
    fn get_ast() -> Array<i64> {
        let ast = ast().lock().unwrap();
        ast[..].into()
    }
}
