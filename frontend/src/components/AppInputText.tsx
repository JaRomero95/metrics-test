import {TextField} from '@mui/material'
import styled from 'styled-components'

export interface iBaseProps {
  label: string,
  value: string | number,
  onChange: (value: any) => void,
  type?: string,
  errors?: Array<string>,
}

interface iProps extends iBaseProps {
  type?: string
}

function AppTextField({label, value, onChange, errors = [], type = 'text'}: iProps) {
  const error = errors[0]

  return (
    <Container>
      <TextField
        variant="standard"
        type={type}
        label={label}
        value={value}
        onChange={event => onChange(event.target.value)}
        helperText={error}
        error={!!error}
        InputLabelProps={{shrink: true}}
        fullWidth
      />
    </Container>
  );
}

const Container = styled.div`
  margin-bottom: 1.2rem;
`

export default AppTextField;
