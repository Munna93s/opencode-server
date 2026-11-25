import { Composition, Solid } from "remotion";

export const HelloWorld = () => {
  return (
    <Solid width={800} height={450} style={{ background: "#4f46e5" }} />
  );
};

export const MyComp = () => (
  <Composition
    id="HelloWorld"
    component={HelloWorld}
    durationInFrames={90}
    fps={30}
    width={800}
    height={450}
  />
);
