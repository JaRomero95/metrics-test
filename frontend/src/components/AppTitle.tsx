import {Typography} from '@mui/material'

interface iProps {
  title: string
}

function AppTitle({title}: iProps) {
  return (
    <Typography variant="h4" component="h1">
      {title}
    </Typography>
  );
}

export default AppTitle;
