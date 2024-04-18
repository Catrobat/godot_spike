// This file handles the uncanny mechanics of sending a notification signal
// (as implemented by godot) from this Godot Engine Singleton to
//
// the top-level "GlobalSignals" autoloaded Scene.
// From there the signals can be further dispached in GDScript
// by connecting to this signal.

use godot::engine::Engine;
use godot::prelude::*;

pub enum GlobalSignals {
    ScriptUpdated,
}

pub fn global_notify(signal: GlobalSignals) {
    let mut global_signals = get_autoload("/root/GlobalSignals");

    let signal_name = match signal {
        GlobalSignals::ScriptUpdated => "script_updated",
    }
    .into();

    global_signals.emit_signal(signal_name, &[]);
}

fn get_autoload(name: &str) -> Gd<Node> {
    let name: NodePath = StringName::from(name).into();

    Engine::singleton()
        .get_main_loop()
        .expect("could not get main loop")
        .cast::<SceneTree>()
        .get_root()
        .expect("could not get root of scene")
        .get_node(name)
        .expect("could not find element in scene")
}
