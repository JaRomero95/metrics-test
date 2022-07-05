import {
  FormControl,
  InputLabel,
  Select,
  MenuItem,
} from '@mui/material'
import styled from 'styled-components'

interface iProps {
  label: string,
  value: string,
  onChange: (value: string) => void,
  options: Array<{label: string, value: string}>
}

function AppSelectField({label, value, onChange, options}: iProps) {
  return (
    <Container>
      <FormControl
        variant="standard"
        fullWidth
      >
        <InputLabel>{label}</InputLabel>

        <Select
          id={label}
          label={label}
          value={value}
          onChange={event => onChange(event.target.value)}
          variant="standard"
        >
          {
            options.map(option => (
              <MenuItem key={option.value} value={option.value}>
                {option.label}
              </MenuItem>
            ))
          }
        </Select>
      </FormControl>
    </Container>
  );
}

const Container = styled.div`
  margin-bottom: 1.2rem;
`

export default AppSelectField;
