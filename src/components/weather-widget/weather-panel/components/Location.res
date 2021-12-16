@react.component
let make = (~name: string) => {
	<div> {React.string(name)} </div>
}
