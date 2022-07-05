import {ReactNode} from 'react';
import {Paper, Typography} from '@mui/material'
import styled from 'styled-components'

interface iProps {
  children: ReactNode,
  title?: string
}

function AppPaper({children, title}: iProps) {
  return (
    <StyledPaper elevation={2}>
      {title && <Title>{title}</Title>}

      {children}
    </StyledPaper>
  );
}

const StyledPaper = styled(Paper)`
  padding: 1rem;
  margin-bottom: 2rem;
`

const Title = styled(Typography)`
  margin-bottom: 1rem !important;
  text-transform: uppercase;
  font-weight: 500 !important;
`

export default AppPaper;
