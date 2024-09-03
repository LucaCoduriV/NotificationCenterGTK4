#![allow(non_snake_case)]

use std::rc::Rc;

use dioxus::{
    desktop::{
        gtk_window::gtk::{
            self,
            prelude::{ContainerExt, GtkWindowExt, WidgetExt},
        },
        tao::{
            self,
            platform::unix::{EventLoopWindowTargetExtUnix, WindowExtUnix},
        },
    },
    prelude::*,
};
use dioxus_logger::tracing::{info, Level};
use gtk_layer_shell::LayerShell;

#[derive(Clone, Routable, Debug, PartialEq)]
enum Route {
    #[route("/")]
    Home {},
    #[route("/blog/:id")]
    Blog { id: i32 },
}

fn main() {
    // Init logger
    dioxus_logger::init(Level::INFO).expect("failed to init logger");
    info!("starting app");

    let launch_builder = LaunchBuilder::desktop_from_gtk_window(|event_loop| {
        let gtk_window = gtk::ApplicationWindow::new(event_loop.gtk_app());
        gtk_window.set_app_paintable(true);
        gtk_window.set_decorated(false);
        gtk_window.stick();
        gtk_window.set_title("This is a wongus");
        let default_vbox = gtk::Box::new(gtk::Orientation::Vertical, 0);
        gtk_window.add(&default_vbox);

        gtk_window.init_layer_shell();
        gtk_window.set_layer(gtk_layer_shell::Layer::Top);
        gtk_window.auto_exclusive_zone_enable();
        gtk_window.set_anchor(gtk_layer_shell::Edge::Top, true);
        gtk_window.set_anchor(gtk_layer_shell::Edge::Right, true);
        gtk_window.set_anchor(gtk_layer_shell::Edge::Bottom, false);
        gtk_window.set_anchor(gtk_layer_shell::Edge::Left, false);
        gtk_window.set_width_request(400);
        gtk_window.set_height_request(400);
        gtk_window.show_all();
        let window =
            tao::window::Window::new_from_gtk_window(event_loop, gtk_window.clone()).unwrap();

        (window, Rc::new(default_vbox))
    });

    launch_builder.launch(App);
}

#[component]
fn App() -> Element {
    rsx! {
        link { rel: "stylesheet", href: "assets/main.css"}
        Router::<Route> {}
    }
}

#[component]
fn Blog(id: i32) -> Element {
    rsx! {
        Link { to: Route::Home {}, "Go to counter" }
        "Blog post {id}"
    }
}

#[component]
fn Home() -> Element {
    let mut count = use_signal(|| 0);

    rsx! {
        Link {
            to: Route::Blog {
                id: count()
            },
            "Go to blog"
        }
        div {
            h1 { "High-Five counter: {count}" }
            button { onclick: move |_| count += 1, "Up high!" }
            button { onclick: move |_| count -= 1, "Down low!" }
        }
    }
}
