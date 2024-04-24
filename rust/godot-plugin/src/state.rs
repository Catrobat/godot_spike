// "Server-Side" state of the Godot Project.
//
// Keeps a hold of the currently selected project,
// script, etc.
//
// TODO: Rethink whether this is really the best way to do this,
// or whether we should just send the full selector down with
// every call from the GDScript side.

use std::sync::{Mutex, OnceLock};

use compiler::Ast;

// TODO: Move this to the compiler infra.
pub type Project = Vec<Sprite>;

#[derive(Debug)]
pub struct Sprite {
    pub name: String,
    pub path: String,
    pub ast: Ast,
}

impl Sprite {
    pub fn new(path: &str) -> Self {
        Self {
            name: path.to_owned(),
            path: path.to_owned(),
            ast: Ast::default(),
        }
    }
}

pub type SpriteID = usize;

#[derive(Default, Debug)]
pub struct EditorState {
    pub project: Project,
    current_sprite: Option<SpriteID>,
}

impl EditorState {
    pub fn set_current_sprite(&mut self, id: SpriteID) {
        if id >= self.project.len() {
            panic!("Invalid sprite id provided!");
        }

        self.current_sprite = Some(id);
    }

    pub fn get_current_sprite(&self) -> SpriteID {
        let id = self.current_sprite.unwrap(); // NOTE: Is this OK, or should we pass the option out?

        if id >= self.project.len() {
            panic!("Invalid sprite id provided!");
        }

        id
    }
}

pub fn editor_state() -> &'static Mutex<EditorState> {
    static EDITOR_STATE: OnceLock<Mutex<EditorState>> = OnceLock::new();
    EDITOR_STATE.get_or_init(|| Mutex::new(EditorState::default()))
}
