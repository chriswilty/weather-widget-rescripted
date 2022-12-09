%%raw("import './Main.css'")

switch ReactDOM.querySelector("#root") {
| Some(root) => ReactDOM.render(<React.StrictMode> <App /> </React.StrictMode>, root)
| None => Js.log("No #root component found")
}
