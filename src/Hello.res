@react.component
let make = (~name: option<string>=?) => {
  let greeting = "Hello " ++ switch name {
  | Some(name) => name
  | None => "stranger"
  } ++ "!"
  <div>
    {React.string(greeting)}
  </div>
}