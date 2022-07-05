import AppInputText, {iBaseProps} from 'components/AppInputText'

interface iProps extends iBaseProps {
  value: string,
  onChange: (value: string) => void
}

function AppDatetimeField(props: iProps) {
  return (
    <AppInputText
      {...props}
      type="datetime-local"
    />
  );
}

export default AppDatetimeField;
