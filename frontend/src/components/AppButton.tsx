import {SyntheticEvent} from 'react'
import {Button} from '@mui/material'

interface iProps {
  label: string,
  onClick: (event: SyntheticEvent) => void
}

function AppButton({label, onClick}: iProps) {
  return (
    <Button
      variant="contained"
      onClick={onClick}
    >
      {label}
    </Button>
  );
}

export default AppButton;
