import AppInputText, {iBaseProps} from 'components/AppInputText'

interface iProps extends iBaseProps {
  value: number,
  onChange: (value: number) => void
}

function AppInputNumber(props: iProps) {
  return (
    <AppInputText
      {...props}
      type="number"
    />
  );
}

export default AppInputNumber;
